function setCost() {
    var paymentElement = document.getElementById("paymentType");
    var typeElement = document.getElementById("appointmentType");
    var appType = typeElement.options[typeElement.selectedIndex].value;

    if (paymentElement.options[typeElement.selectedIndex].value != "free") {
        document.getElementById("payment-value").value = getAppointmentCost(appType).toFixed(2);
    }

    // Give option of adding a shave if man's appointment
    var element = document.getElementById("shave-div");
    if (/\bmens/.test(appType)) {
        if (element.classList.contains("hide")) {
            element.classList.remove("hide");
        }
    } else {
        if (!element.classList.contains("hide")) {
            element.classList.add("hide");
        }
    }
}

// Get value of radio button given name
function getRadioValue(name) {
    var options = document.getElementsByName(name);
    for (var i=0; i < options.length; i++) {
        if (options[i].checked) {
            return options[i].value;
        }
    }
}

function getAppointmentCost(type) {
    switch (type) {
        case 'mensHaircut': return 28.0;
        case 'mensBuzzcut': return 20.0;
        case 'mensFade': return 20.0;
        //case 'mensBeard': return '18.00';
        case 'ladiesHaircut': return 28.0;
        case 'boysCut': return 20.0;
        case 'girlsCut': return 20.0;
        case 'pensionCut': return 23.0;
        default: return 0.0;
    }
}

function addShave() {
    var element = document.getElementById("payment-value");
    var total = parseFloat(element.value);

    if (getRadioValue("shave") == "shaved") {
        if (total <= 28.00) {
            total += 18.0;
        }
    } else {
        if (total >= 38.0) {
            total -= 18.0;
        }
    }

    element.value = total.toFixed(2);
}

function checkFree() {
    var paymentElement = document.getElementById("payment-value");
    var payment = parseFloat(paymentElement.value);

    var typeElement = document.getElementById("paymentType");
    if (typeElement.options[typeElement.selectedIndex].value == "free") {
        payment = 0.0;
        paymentElement.value = payment.toFixed(2);
    } else {
        if (payment == 0.0) {
            var typeElement = document.getElementById("appointmentType");
            var appType = typeElement.options[typeElement.selectedIndex].value;
            payment = getAppointmentCost(appType);
            paymentElement.value = payment.toFixed(2);

            // Check for shave
            if (/\bmens/.test(appType)) {
                addShave();
            }
        }
    }
}