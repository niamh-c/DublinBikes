/**
 * This function will convert all letters except the first in the passed in string to lowercase.
 *
 */

function lowerCaseMe(string) {
    return string.replace(/\w\S*/g, function (word) {
        return word.charAt(0) + word.slice(1).toLowerCase();
    });
}