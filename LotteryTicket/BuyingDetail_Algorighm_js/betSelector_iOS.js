/**
 * User: Mercury Allen
 * Date: 2017/11/20
 * @description 注单选择器
 * Modify: licheng  改为原生的纯javascript代码
 */

/**
 * 是否需要检测重号
 * @param playing
 * @returns {boolean}
 */
const isCheckRepeatCode = function(playing) {
    return playing.hasOwnProperty('equal') && playing.equal === 2;
}


/**
 * 校验单选时是否出现重号
 * @param codeOfChosen  已选择的号码
 * @param curPlace      当前位置
 * @param curCode       当前选择的号码
 * @returns {boolean}
 */
const checkRadioRepeatCode = function(codeOfChosen, curPlace, curCode) {
    for (var i in codeOfChosen) {
        if (codeOfChosen.hasOwnProperty(i) && i !== curPlace) {
            return codeOfChosen[i].some(function(value) { return value === curCode });
        }
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
const checkMultipleRepeatCode = function(codeOfChosen, selectCodes, place) {
    var codes = [];
    const oldLength = selectCodes.betCodes.length;
    for (var i in codeOfChosen) {
        if (codeOfChosen.hasOwnProperty(i) && i !== place) {
            codes = [...codes, ...codeOfChosen[i]];
            //codes.push(codeOfChosen[i]);
        }
    }
    selectCodes.betCodes = selectCodes.betCodes.filter(function(value) { return codes.indexOf(value) === -1 });
    if (oldLength > selectCodes.betCodes.length) {
        selectCodes.isRepeatCode = true;
    }
    return selectCodes;
};

/**
 * 获取验证规则
 * @param playingArea
 * @returns {{}}
 */
const getValidationRules = function(playingArea) {
    const rules = {};
    playingArea.map(function(item){ rules[item.id] = item.rule });
    return rules;
};

/**
 * 基本验证方法
 * @param playingArea
 * @param selectedCode
 * @param severalPos
 * @returns {boolean}
 */
const validationCode = function(playingArea, selectedCode, severalPos) {
    const validationRules = getValidationRules(playingArea);
    var fulfillTimes = 0;
    for (var i in validationRules) {
        if (selectedCode.hasOwnProperty(i)) {
            selectedCode[i].length >= validationRules[i] && fulfillTimes++;
            //if (selectedCode[i].length >= validationRules[i]) {
            //    fulfillTimes ++;
            //}
        }
        if (fulfillTimes >= severalPos) {
            return true;
        }
    }
    return false;
};

/**
 * 验证Pos              // 验证特殊玩法  area_pos.choose.cout>=area_pos.rule
 * @param playPos
 * @param selectedPos
 */
const validationPos = function(playPos, selectedPos) {
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
function runRadioChoice(playing, codeOfChosen, curPlace, curCode) {
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
function runMultipleChoice(playing, codeOfChosen, place, operatingType) {
    const selectCodes = {
        betCodes: [],
        isRepeatCode: false
    };
    var playingList = [], codeList = [];
    if (playing.hasOwnProperty('list')) {
        playingList = playing.list;
    }
    switch (operatingType) {
        case 'all':
            codeList = playingList;
            break;
        case 'big':
            codeList = playingList.filter(function(value, i) { return i>= Math.ceil(playingList.length/2) })
            break;
        case 'small':
            codeList = playingList.filter(function(value, i) { return i < Math.ceil(playingList.length / 2) });
            break;
        case 'odd':
            codeList = playingList.filter(function(value) { return value.id % 2 !== 0 });
            break;
        case 'even':
            codeList = playingList.filter(function(value) { return value.id % 2 === 0 });
            break;
        case 'clear':
            break;
    }
    codeList.map(function(code) { selectCodes.betCodes.push(code.id) });
    if (isCheckRepeatCode(playing)) {
        return checkMultipleRepeatCode(codeOfChosen, selectCodes, place);
    } else {
        return selectCodes;
    }
    return selectCodes;
}

/**
 * 验证注单是否完成
 * @param playing
 * @param selectedCode
 * @param severalPos
 * @returns {boolean}
 */
function validationIsFinished(playing, selectedCode, severalPos) {
    //const {area_pos: playPos, area: playArea} = playing;
    const playPos = playing.area_pos, playArea = playing.area;
    var isFinishedPos = true;
    if (!Array.isArray(playPos) && selectedCode.hasOwnProperty('pos')) {
        isFinishedPos = validationPos(playPos, selectedCode['pos']);  // 特殊玩法
    }
    if (!isFinishedPos) {
        return false;
    } else {
        return validationCode(playArea, selectedCode, severalPos);
    }
}
