/**
 * User: Mercury Allen
 * Mail: mercurydocker@gmail.com
 * Date: 2017/7/30
 * Time: 上午12:06
 * @description 注单选择器
 */

/**
 * 是否需要检测重号
 * @param playing
 * @returns {boolean}
 */
const isCheckRepeatCode = playing => playing.hasOwnProperty('equal') && playing.equal === 2;


/**
 * 校验单选时是否出现重号
 * @param codeOfChosen  已选择的号码
 * @param curPlace      当前位置
 * @param curCode       当前选择的号码
 * @returns {boolean}
 */
const checkRadioRepeatCode = (codeOfChosen, curPlace, curCode) => {
    for (let i in codeOfChosen) {
        if (codeOfChosen.hasOwnProperty(i) && i !== curPlace) return codeOfChosen[i].some(value => value === curCode);
    }
    return false;
};

/**
 * 校验多选时是否出现重号
 * @param codeOfChosen
 * @param selectCodes
 * @param place
 * @returns {*}
 */
const checkMultipleRepeatCode = (codeOfChosen, selectCodes, place) => {
    let codes = [];
    const oldLength = selectCodes.betCodes.length;
    for (let i in codeOfChosen) {
        if (codeOfChosen.hasOwnProperty(i) && i !== place) codes = [...codes, ...codeOfChosen[i]]
    }
    selectCodes.betCodes = selectCodes.betCodes.filter(value => codes.indexOf(value) === -1);
    if (oldLength > selectCodes.betCodes.length) selectCodes.isRepeatCode = true;
    return selectCodes;
};

/**
 * 获取验证规则
 * @param playingArea
 * @returns {{}}
 */
const getValidationRules = (playingArea) => {
    const rules = {};
    playingArea.map(item => rules[item.id] = item.rule);
    return rules;
};

/**
 * 基本验证方法
 * @param playingArea
 * @param selectedCode
 * @param severalPos
 * @returns {boolean}
 */
const validationCode = (playingArea, selectedCode, severalPos) => {
    const validationRules = getValidationRules(playingArea);
    let fulfillTimes = 0;
    for (let i in validationRules) {
        if (selectedCode.hasOwnProperty(i)) {
            selectedCode[i].length >= validationRules[i] && fulfillTimes++;
        }
        if (fulfillTimes >= severalPos) return true;
    }
    return false;
};

/**
 * 验证Pos
 * @param playPos
 * @param selectedPos
 */
const validationPos = (playPos, selectedPos) => {
    return selectedPos.length >= playPos.rule;
};


/**
 * 执行单选
 * @param playing       玩法
 * @param codeOfChosen  已选择的号码
 * @param curPlace      当前位置
 * @param curCode       当前选择的号码
 * @returns {boolean}
 */
export function runRadioChoice(playing, codeOfChosen, curPlace, curCode) {
    if (isCheckRepeatCode(playing)) {
        return checkRadioRepeatCode(codeOfChosen, curPlace, curCode);
    } else {
        return false;
    }
}

/**
 * 快速选择注单号码
 * @param playing       玩法
 * @param codeOfChosen  已选择的号码
 * @param place         位置
 * @param operatingType 操作类型
 * @returns {*}
 */
export function runMultipleChoice(playing, codeOfChosen, place, operatingType) {
    const selectCodes = {
        betCodes: [],
        isRepeatCode: false
    };
    let playingList = [],
        codeList = [];
    if (playing.hasOwnProperty('list')) playingList = playing.list;
    switch (operatingType) {
        case 'all':
            codeList = playingList;
            break;
        case 'big':
            codeList = playingList.filter((value, i) => i >= Math.ceil(playingList.length / 2));
            break;
        case 'small':
            codeList = playingList.filter((value, i) => i < Math.ceil(playingList.length / 2));
            break;
        case 'odd':
            codeList = playingList.filter(value => value.id % 2 !== 0);
            break;
        case 'even':
            codeList = playingList.filter(value => value.id % 2 === 0);
            break;
        case 'clear':
            break;
    }
    codeList.map(code => selectCodes.betCodes.push(code.id));
    if (isCheckRepeatCode(playing)) {
        return checkMultipleRepeatCode(codeOfChosen, selectCodes, place);
    } else {
        return selectCodes;
    }
}

/**
 * 验证注单是否完成
 * @param playing
 * @param selectedCode
 * @param severalPos
 * @returns {boolean}
 */
export function validationIsFinished(playing, selectedCode, severalPos) {
    const {area_pos: playPos, area: playArea} = playing;
    let isFinishedPos = true;
    if (!Array.isArray(playPos) && selectedCode.hasOwnProperty('pos')) {
        isFinishedPos = validationPos(playPos, selectedCode['pos']);
    }
    if (isFinishedPos === false) {
        return false;
    } else {
        return validationCode(playArea, selectedCode, severalPos);
    }
}
