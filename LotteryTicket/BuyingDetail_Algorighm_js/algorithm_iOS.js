/**
 * User: Mercury Allen
 * Date: 2017/11/20
 * @description 注单选择器
 * Modify: licheng  改为原生的纯javascript代码
 */

/**
 * 奖金倍数
 * @type {[*]}
 */
const BonusMultiple = [
    {betPattern: 1, name: '2元', money: 2000, multiple: 1},
    {betPattern: 2, name: '1元', money: 1000, multiple: 2},
    {betPattern: 3, name: '2角', money: 200, multiple: 10},
    {betPattern: 4, name: '1角', money: 100, multiple: 20},
    {betPattern: 5, name: '2分', money: 20, multiple: 100},
    {betPattern: 6, name: '2厘', money: 2, multiple: 1000},
];

/**
 * 特殊玩法通用算法
 * @type {{}}
 */
const specialAlgorithmCommon = {
    // 计算任意直选类型的注单总数
    calculateAnyDirectly: function(codes, type) {
        var numberRow = countNumberOfRows(codes, type),
            start = 0,
            length = numberRow.length,
            result = [],
            count = 0,
            numbers = [0];
        count += type;
        anyDirectlyTotal(start, length, type, count, numberRow, result, numbers);
        return numbers[0];
    },
    // 含有map的通用算法
    calculateMappingNumber: function(codes, map, type) {
        var numbers = 0, posNumber = 1;
        for (var i in codes) {
            if (codes.hasOwnProperty(i)) {
                if (i === 'pos') {
                    posNumber *= calculateCombination(codes[i].length, type);
                } else {
                    codes[i].code.map(function(item) { numbers += map[item + ''] });
                }
            }
        }
        return numbers * posNumber;
    },
    // 含pos组选通用算法
    calculateGroupChooseByRule: function(codes, type) {
        var numbers = 1;
        for (var i in codes) {
            if (codes.hasOwnProperty(i)) {
                if (i === 'pos') {
                    numbers *= calculateCombination(codes[i].length, type);
                } else {
                    numbers *= calculateCombination(codes[i].code.length, codes[i].rule)
                }
            }
        }
        return numbers;
    },
    // 计算定位胆
    calculatePositioningDaring: function(codes) {
        var number = 0;
        for (var i in codes) {
            if (codes.hasOwnProperty(i)) {
                number += codes[i].code.length;
            }
        }
        return number;
    },
    // 计算奇偶数
    calculateOddEvenCode: function(codes) {
        var numbers = 0;
        for (var i in codes) {
            if (codes.hasOwnProperty(i)) {
                codes[i].code.map(function(item) { numbers += item === 3 || item === 0 ? 1 : 3 });
            }
        }
        return numbers;
    },
    // 计算二星和值
    calculateSum: function(codes) {
        var numbers = 0;
        for (var i in codes) {
            if (codes.hasOwnProperty(i)) {
                codes[i].code.map(function(item) {
                      // 从最大值到最小值有多少个可能，比如9到8有2个
                      const maxNum = Math.min(item, 9), minNum = Math.max(0, item - 9);
                      numbers += maxNum - minNum + 1;
                });
            }
        }
        return numbers;
    },
    // 计算二星跨度
    calculateSpan: function(codes) {
        var numbers = 0;
        for (var i in codes) {
            if (codes.hasOwnProperty(i)) {
                codes[i].code.map(function(differ) { numbers += differ === 0 ? 10 : (10 - differ) * 2 });
            }
        }
        return numbers;
    },
    // 计算二星包胆
    calculateSiegePoint: function(codes) {
        var numbers = 0;
        for (var i in codes) {
            if (codes.hasOwnProperty(i)) {
                codes[i].code.map(function(item) { numbers += Math.min(item, 9) - Math.ceil(item / 2) + 1 });
            }
        }
        return numbers;
    },
    // 计算三星和值
    calculateThreeStartSum: function(codes) {
        const map = {
            "18": 55, "19": 45, "20": 36, "21": 28, "22": 21, "23": 15, "24": 10, "25": 6, "26": 3, "27": 1,
            "17": 63, "16": 69, "15": 73, "14": 75, "13": 75, "12": 73, "11": 69, "10": 63, "9": 55, "8": 45,
            "7": 36, "6": 28, "5": 21, "4": 15, "3": 10, "2": 6, "1": 3, "0": 1
        };
        return specialAlgorithmCommon.calculateMappingNumber(codes, map);
    },
    // 计算三星包点
    calculateThreeStartSiegePoint: function(codes) {
        const map = {
            "18": 12, "19": 10, "20": 8, "21": 7, "22": 5, "23": 4, "24": 3, "25": 2, "26": 1, "27": 1,
            "17": 13, "16": 14, "15": 15, "14": 15, "13": 15, "12": 15, "11": 14, "10": 13, "9": 12, "8": 10,
            "7": 8, "6": 7, "5": 5, "4": 4, "3": 3, "2": 2, "1": 1, "0": 1
        };
        return specialAlgorithmCommon.calculateMappingNumber(codes, map);
    },
    // 计算排列
    calculatePermutation: function(codes) {
        const codesArray = [];
        for (var i in codes){
            if (codes.hasOwnProperty(i)){
                codesArray.push(codes[i].code);
            }
        }
        return arrangementAlgorithm(codesArray).length;
    }

};

/**
 * 特殊玩法算法
 * @type {{}}
 */
const specialAlgorithm = {
    // 前二直选具体玩法（每行选项值不能相同）
    PlayingFrontTwoSYDirectly: function(codes) {
        return specialAlgorithmCommon.calculatePermutation(codes);
    },
    // 前三直选具体玩法(每行选项值不能相同)
    PlayingFrontThreeSYDirectly: function(codes) {
        return specialAlgorithmCommon.calculatePermutation(codes);
    },
    // 猜前二名
    PlayingChampionFrontTwo: function(codes) {
        return specialAlgorithmCommon.calculatePermutation(codes);
    },
    // 猜前三名
    PlayingChampionFrontThree: function(codes) {
        return specialAlgorithmCommon.calculatePermutation(codes);
    },
    // 任二直选
    PlayingTwoAnyDirectly: function(codes) {
        return specialAlgorithmCommon.calculateAnyDirectly(codes, 2);
    },
    // 任二直选合值
    PlayingTwoAnyDirectlySum: function(codes) {
        const map = {
            "18": 1, "17": 2, "16": 3, "15": 4, "14": 5, "13": 6, "12": 7, "11": 8, "10": 9, "9": 10, "8": 9,
            "7": 8, "6": 7, "5": 6, "4": 5, "3": 4, "2": 3, "1": 2, "0": 1
        };
        return specialAlgorithmCommon.calculateMappingNumber(codes, map, 2);
    },
    // 任二组选
    PlayingTwoAnyChooseGroup: function(codes) {
        return specialAlgorithmCommon.calculateGroupChooseByRule(codes, 2);
    },
    // 任二组选和值
    PlayingTwoAnyChooseGroupSum: function(codes) {
        const map = {
            "17": 1, "16": 1, "15": 2, "14": 2, "13": 3, "12": 3, "11": 4, "10": 4, "9": 5, "8": 4,
            "7": 4, "6": 3, "5": 3, "4": 2, "3": 2, "2": 1, "1": 1
        };
        return specialAlgorithmCommon.calculateMappingNumber(codes, map, 2);
    },
    // 任三直选
    PlayingThreeAnyDirectly: function(codes) {
        return specialAlgorithmCommon.calculateAnyDirectly(codes, 3);
    },
    // 任三直选和值
    PlayingThreeAnyDirectlySum: function(codes) {
        const map = {
            "27": 1, "26": 3, "25": 6, "24": 10, "23": 15, "22": 21, "21": 28, "20": 36, "19": 45, "18": 55,
            "17": 63, "16": 69, "15": 73, "14": 75, "13": 75, "12": 73, "11": 69, "10": 63, "9": 55, "8": 45,
            "7": 36, "6": 28, "5": 21, "4": 15, "3": 10, "2": 6, "1": 3, "0": 1
        };
        return specialAlgorithmCommon.calculateMappingNumber(codes, map, 3);
    },
    // 任三组选和值
    PlayingThreeAnyChooseGroupSum: function(codes) {
        const map = {
            "26": 1, "25": 2, "24": 2, "23": 4, "22": 5, "21": 6, "20": 8, "19": 10, "18": 11,
            "17": 13, "16": 14, "15": 14, "14": 15, "13": 15, "12": 14, "11": 14, "10": 13, "9": 11,
            "8": 10, "7": 8, "6": 6, "5": 5, "4": 4, "3": 2, "2": 2, "1": 1,
        };
        return specialAlgorithmCommon.calculateMappingNumber(codes, map, 3);
    },
    // 任三组三
    PlayingThreeAnyThreeGroup: function(codes) {
        //任意2个会有2注单，以此为基数乘以组合数量，即为总注数
        return specialAlgorithmCommon.calculateGroupChooseByRule(codes, 3) * 2;
    },
    // 任三组六
    PlayingThreeAnySixGroup: function(codes) {
        return specialAlgorithmCommon.calculateGroupChooseByRule(codes, 3);
    },
    // 任四直选
    PlayingFourAnyDirectly: function(codes) {
        return specialAlgorithmCommon.calculateAnyDirectly(codes, 4);
    },
    // 任四组选24
    PlayingFourAnyChooseGroup24: function(codes) {
        return specialAlgorithmCommon.calculateGroupChooseByRule(codes, 4);
    },
    // 任四组选12
    PlayingFourAnyChooseGroup12: function(codes) {
        return specialAlgorithmCommon.calculateGroupChooseByRule(codes, 4);
    },
    // 任四组选6
    PlayingFourAnyChooseGroup6: function(codes) {
        return specialAlgorithmCommon.calculateGroupChooseByRule(codes, 4);
    },
    // 任四组选4
    PlayingFourAnyChooseGroup4: function(codes) {
        return specialAlgorithmCommon.calculateGroupChooseByRule(codes, 4);
    },
    // 前五定位胆
    PlayingFrontFivePositioningDaring: function(codes) {
        return specialAlgorithmCommon.calculatePositioningDaring(codes);
    },
    // 前三定位胆
    PlayingFrontThreePositioningDaring: function(codes) {
        return specialAlgorithmCommon.calculatePositioningDaring(codes);
    },
    // 后五定位胆
    PlayingBackFivePositioningDaring: function(codes) {
        return specialAlgorithmCommon.calculatePositioningDaring(codes);
    },
    // 定位胆
    PlayingPositioningDaring: function(codes) {
        return specialAlgorithmCommon.calculatePositioningDaring(codes);
    },
    // 前二组选包胆
    PlayingFrontTwoChooseGroupSiegeDaring: function(codes) {
        // 与所选个数成9倍关系
        return codes.a.code.length * 9;
    },
    // 后二组选包胆
    PlayingBackTwoChooseGroupSiegeDaring: function(codes){
        // 与所选个数成9倍关系
        return codes.a.code.length * 9;
    },
    // 猜奇次
    PlayingGuessOddCode: function(codes) {
        return specialAlgorithmCommon.calculateOddEvenCode(codes);
    },
    // 猜偶次
    PlayingGuessEvenCode: function(codes) {
        return specialAlgorithmCommon.calculateOddEvenCode(codes);
    },
    // 前二和值
    PlayingFrontTwoSum: function(codes) {
        return specialAlgorithmCommon.calculateSum(codes);
    },
    // 后二和值
    PlayingBackTwoSum: function(codes) {
        return specialAlgorithmCommon.calculateSum(codes);
    },
    // 前二跨度
    PlayingFrontTwoSpan: function(codes) {
        return specialAlgorithmCommon.calculateSpan(codes);
    },
    // 后二跨度
    PlayingBackTwoSpan: function(codes) {
        return specialAlgorithmCommon.calculateSpan(codes);
    },
    // 前二包点
    PlayingFrontTwoSiegePoint: function(codes) {
        return specialAlgorithmCommon.calculateSiegePoint(codes);
    },
    // 后二包点
    PlayingBackTwoSiegePoint: function(codes) {
        return specialAlgorithmCommon.calculateSiegePoint(codes);
    },
    // 前三和值
    PlayingFrontThreeSum: function(codes) {
        return specialAlgorithmCommon.calculateThreeStartSum(codes);
    },
    // 中三和值
    PlayingMiddleThreeSum: function(codes) {
        return specialAlgorithmCommon.calculateThreeStartSum(codes);
    },
    // 后三和值
    PlayingBackThreeSum: function(codes) {
        return specialAlgorithmCommon.calculateThreeStartSum(codes);
    },
    // 前三包点
    PlayingFrontThreeSiegePoint: function(codes) {
        return specialAlgorithmCommon.calculateThreeStartSiegePoint(codes);
    },
    // 中三包点
    PlayingMiddleThreeSiegePoint: function(codes) {
        return specialAlgorithmCommon.calculateThreeStartSiegePoint(codes);
    },
    // 后三包点
    PlayingBackThreeSiegePoint: function(codes) {
        return specialAlgorithmCommon.calculateThreeStartSiegePoint(codes);
    },
    // 三星包点
    PlayingThreeStarSiegePoint: function(codes) {
        return specialAlgorithmCommon.calculateThreeStartSiegePoint(codes);
    }
};

/**
 * 扩展算法
 * @type {{product: ((p1:*))}}
 */
const extendedAlgorithm = {
    // 乘积
    product: function(a) {
        var base = 1;
        if (a instanceof Array === false) return 0;
        a.map(function(i) {
            if (typeof i !== 'number') return 0;
            base = base * i;
        });
        return base;
    },
};

/**
 * 计算注单每行号码的个数
 * @param codes
 * @param type
 * @returns {*}
 */
const countNumberOfRows = function(codes, type) {
    var rowElementNumber = [],
        countNumberColumns = codes.length;
    if (countNumberColumns < type) return false;
    for (var i in codes) {
        if (codes.hasOwnProperty(i)) {
            rowElementNumber.push(codes[i].code.length)
        }
    }
    return rowElementNumber;
};

/**
 * 计算任选总注单数
 * @param start
 * @param length
 * @param type
 * @param count
 * @param value
 * @param result
 * @param numbers
 */
const anyDirectlyTotal = function(start, length, type, count, value, result, numbers) {
    for (var i = start; i < length + 1 - count; i++) {
        result[count - 1] = i;
        if (count - 1 === 0) {
            var group = [];
            for (var j = type - 1; j >= 0; j--) {
                group.push(value[result[j]]);
            }
            numbers[0] += extendedAlgorithm.product(group);
        } else {
            anyDirectlyTotal(i + 1, length, type, count - 1, value, result, numbers);
        }
    }
};

/**
 * 获取奖金倍数信息
 * @param betPattern
 * @returns {*}
 */
const getBonusMultiple = function(betPattern) {
    const bonusMultipleMessage = BonusMultiple.filter(function(item) { return item.betPattern === betPattern });
    if (bonusMultipleMessage.length > 0) {
        return bonusMultipleMessage[0];
    }
    return {};
};

/**
 * 计算注单金额
 * @param numbers
 * @param singleMoney
 * @param multiple
 */
const calculateBetMoney = function(numbers, singleMoney, multiple) { return numbers * singleMoney * multiple };

/**
 * 整理要计算的号码
 * @param playingArea
 * @param selectedCodes
 * @returns {{}}
 */
const generateCodes = function(playingArea, selectedCodes) {
    const codes = {};
    playingArea.map(function(i) {
        codes[i.id] = {rule: i.rule, code: []};
    });
    for (var i in selectedCodes) {
        if (selectedCodes.hasOwnProperty(i) && codes.hasOwnProperty(i)) {
            codes[i].code = selectedCodes[i];
        } else {
            codes[i] = selectedCodes[i];
        }
    }
    return codes;
};

/**
 * 基础算法
 * @param codes
 * @param betNote
 * @returns {*}
 */
const baseAlgorithm = function(codes, betNote) {
    var betNumber = betNote;
    for (var i in codes) {
        if (codes.hasOwnProperty(i)) {
            var m = codes[i].code.length, n = codes[i].rule;
            if (n === 1) {
                betNumber = betNumber * m;
            } else betNumber *= calculateCombination(m, n);
        }
    }
    return betNumber;
};

/**
 * 计算组合数
 * @param m
 * @param n
 * @description 计算组合数，计算从m个数中取出n个的组合数，其中 m >= n
 * @returns {number}
 */
const calculateCombination = function(m, n) {
    var initialValue = 1, differ = m - n, divide = 1, divisor = 1;
    if (differ > 0) {
        for (var i = differ, b = m; i > 0; i--, b--) {
            divide = divide * b;
            divisor = divisor * i;
        }
        return initialValue * (divide / divisor);
    }
    return initialValue;
};

/**
 * 排列数算法
 * @param arr
 * @returns {*}
 */
const arrangementAlgorithm = function(arr) {
    if(arr.length === 1){
        return arr[0];
    }
    const a = [],
        tmpArr = arr.shift(),
        b = arrangementAlgorithm(arr);
    for (var i = 0, tmpLength = tmpArr.length; i < tmpLength; i ++) {
        for (var j = 0, bLength = b.length; j < bLength; j ++){
            if (b[j] instanceof Array){
                if(b[j].indexOf(tmpArr[i]) !== -1){
                    continue;
                }
                a.push(b[j].concat(tmpArr[i]));
            } else {
                if (b[j] === tmpArr[i]){
                    continue;
                }
                a.push([b[j]].concat(tmpArr[i]));
            }
        }
    }
    return a;
};

/**
 * 执行计算
 * @param playingMessage
 * @param orderMessage
 * @returns {{numbers: number, amount: number}}
 */
function runCalculate(playingMessage, orderMessage) {
    const bettingPattern = orderMessage.bettingPattern, multiple = orderMessage.multiple, selectedCodes = orderMessage.bettingPos.pos,
        betInfo = {
            numbers: 0,
            amount : 0
        },
        curBonusMultiple = getBonusMultiple(bettingPattern),
        sourceCodes      = generateCodes(playingMessage.area, selectedCodes),
        playingFunction  = playingMessage.playing;
    if (specialAlgorithm.hasOwnProperty(playingFunction)) {
        betInfo.numbers = specialAlgorithm[playingFunction](sourceCodes);
    } else {
        betInfo.numbers = baseAlgorithm(sourceCodes, playingMessage.base_note);
    }
    betInfo.amount = calculateBetMoney(betInfo.numbers, curBonusMultiple.money, multiple);
    return betInfo;
}

/**
 * 计算最高奖金
 * @param maxBonus
 * @param oddsPattern
 * @param multiple
 * @returns {number}
 */
function calculateMaxBonus(maxBonus, oddsPattern, multiple) {
    return maxBonus * oddsPattern * multiple;
}
