

//export function calculateMaxBonus_export(maxBonus, oddsPattern, multiple) {
//    return maxBonus * oddsPattern * multiple;
//}
function calculateMaxBonus(maxBonus, oddsPattern, multiple) {
    return maxBonus * oddsPattern * multiple;
}


//const jsFuncTest0 = p0 => p0 + 10;
const jsFuncTest0 = function(p0) {
    return p0 + 10;
};


//const jsFuncTest1 = (p0_bool, p1_int, p2_str) => {
//    return "params are p0_bool=" + p0_bool + ", p1_int=" + p1_int + ", p2_str=" + p2_str;
//};
const jsFuncTest1 = function(p0_bool, p1_int, p2_str) {
    if (p0_bool === true) {
        return "params are p0_bool=" + p0_bool + ", p1_int=" + p1_int + ", p2_str=" + p2_str;
    }
    else if (p0_bool == false) {
        return 123;
    }
    else {
        return p0_bool;
    }
};


const checkRadioRepeatCode = function(codeOfChosen, curPlace, curCode) {
//    for (let i in codeOfChosen) {
//        if (codeOfChosen.hasOwnProperty(i) && i !== curPlace) {
//            return codeOfChosen[i].some(value => value === curCode);
//        }
//    }
    for (var i in codeOfChosen) {
        if (codeOfChosen.hasOwnProperty(i) && i !== curPlace) {
            return codeOfChosen[i].some(function(value) { return value === curCode });
        }
    }
    return false;
};


function validationIsFinished(playing) {
    //const {area_pos: playPos, area: playArea} = playing;
    const playPos = playing.area_pos, playArea = playing.area;
}
function runCalculate(playingMessage, orderMessage) {
//    const { bettingPattern, multiple, bettingPos: {pos: selectedCodes} } = orderMessage,
//         betInfo = {
//                numbers: 0,
//                amount : 0
//            },
//        curBonusMultiple = getBonusMultiple(bettingPattern),
//        sourceCodes      = generateCodes(playingMessage.area, selectedCodes),
//        {playing : playingFunction}  = playingMessage;
    const bettingPattern = orderMessage.bettingPattern, multiple = orderMessage.multiple, selectedCodes = orderMessage.bettingPos.pos,
    betInfo = {
    numbers: 0,
        amount : 0
    },
    curBonusMultiple = getBonusMultiple(bettingPattern),
    sourceCodes      = generateCodes(playingMessage.area, selectedCodes),
    playingFunction  = playingMessage.playing;
}


function jsFuncTest2() {
    console.log('*_*');
    return Math.ceil(15.1);  // 向上取整
}


//function formatPenny(money = 0) {  将厘转换为元（1111厘 == 1.111元）
function formatPenny(money) {
    if (typeof money !== 'number') {
        return '0.000元';
    }
    return (money / 1000).toFixed(3) + '元';
}

