// ==UserScript==
// @name         PhoneTool NFT
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  For Hackathon purposes only
// @author       You
// @match        https://phonetool.amazon.com/users/*
// @icon         https://www.google.com/s2/favicons?domain=amazon.com
// @grant        none
// @require      https://cdn.jsdelivr.net/npm/web3@latest/dist/web3.min.js
// @require      https://requirejs.org/docs/release/2.3.5/minified/require.js
// @require      https://code.jquery.com/jquery-3.2.1.min.js

// ==/UserScript==
(function() {
    'use strict';

    // Your code here...
    var alias = document.URL.split('/').at(-1);
    var users = {
        'ronkenia': '0xDeaA23841139685e949F9c84648498314F038770',
        'doolaugh': '0x0e8E8A65f354ac318F29c402093efa95B8718aB7'
    };

    var Web3 = require(['./web3']);
    var web3 = new window.Web3(new window.Web3.providers.HttpProvider("http://localhost:9545"));

    var abi = JSON.parse('[{"inputs":[{"internalType":"address","name":"_svgContractAddress","type":"address"}],"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"owner","type":"address"},{"indexed":true,"internalType":"address","name":"approved","type":"address"},{"indexed":true,"internalType":"uint256","name":"tokenId","type":"uint256"}],"name":"Approval","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"owner","type":"address"},{"indexed":true,"internalType":"address","name":"operator","type":"address"},{"indexed":false,"internalType":"bool","name":"approved","type":"bool"}],"name":"ApprovalForAll","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"from","type":"address"},{"indexed":true,"internalType":"address","name":"to","type":"address"},{"indexed":true,"internalType":"uint256","name":"tokenId","type":"uint256"}],"name":"Transfer","type":"event"},{"inputs":[{"internalType":"address","name":"to","type":"address"},{"internalType":"uint256","name":"tokenId","type":"uint256"}],"name":"approve","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"owner","type":"address"}],"name":"balanceOf","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"uint256","name":"tokenId","type":"uint256"}],"name":"getApproved","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"address","name":"owner","type":"address"},{"internalType":"address","name":"operator","type":"address"}],"name":"isApprovedForAll","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[],"name":"name","outputs":[{"internalType":"string","name":"","type":"string"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"uint256","name":"tokenId","type":"uint256"}],"name":"ownerOf","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"address","name":"from","type":"address"},{"internalType":"address","name":"to","type":"address"},{"internalType":"uint256","name":"tokenId","type":"uint256"}],"name":"safeTransferFrom","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"from","type":"address"},{"internalType":"address","name":"to","type":"address"},{"internalType":"uint256","name":"tokenId","type":"uint256"},{"internalType":"bytes","name":"_data","type":"bytes"}],"name":"safeTransferFrom","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"operator","type":"address"},{"internalType":"bool","name":"approved","type":"bool"}],"name":"setApprovalForAll","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"bytes4","name":"interfaceId","type":"bytes4"}],"name":"supportsInterface","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[],"name":"svgContractAddress","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[],"name":"symbol","outputs":[{"internalType":"string","name":"","type":"string"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"uint256","name":"index","type":"uint256"}],"name":"tokenByIndex","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"address","name":"owner","type":"address"},{"internalType":"uint256","name":"index","type":"uint256"}],"name":"tokenOfOwnerByIndex","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[],"name":"totalSupply","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"address","name":"from","type":"address"},{"internalType":"address","name":"to","type":"address"},{"internalType":"uint256","name":"tokenId","type":"uint256"}],"name":"transferFrom","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"string","name":"_alias","type":"string"}],"name":"mintFoundationsIcon","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"string","name":"_alias","type":"string"}],"name":"mintMobileBetaIcon","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"_tokenId","type":"uint256"}],"name":"tokenURI","outputs":[{"internalType":"string","name":"","type":"string"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"address","name":"_wallet","type":"address"}],"name":"walletOfOwner","outputs":[{"internalType":"uint256[]","name":"","type":"uint256[]"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"address","name":"_newOwner","type":"address"}],"name":"transferOwnership","outputs":[],"stateMutability":"nonpayable","type":"function"}]');
    var contract = new web3.eth.Contract(abi);
    contract.options.address = "0xEA4218f6d7DEAF45fe0fDb3e26654373dFa33f07";

    console.log(contract.methods);
    console.log(contract.methods);

    var x = [];
    var nftHolder;

    var mainHTML = $();

    var empty = $("<div id='lookForThis'></div>");

    var topHTML = `<div class="list_item" id="19305784">
<div class="undo widget-placeholder hide" id="undo-2">
  <div class="undo-content">
    NFTs has been removed.
    <a id="undo-link-2" data-remote="true" rel="nofollow" data-method="put" href="/widgets/2/toggle_display?display=true">Undo.</a>
  </div>
</div>

<div class="well content-well" id="widget-2">
<div class="widget-move-handle ui-sortable-handle">
<div class="title widget-title">
<i class="icon-trophy"></i>
NFTs
</div>
<div class="subtitle widget-title">
</div>
<div class="title pull-right">
<div class="widget-x-button" id="widget-collapse-2">
<a class="muted" data-remote="true" rel="nofollow" data-method="put" href="/widgets/2/toggle_display?collapsed=true"><i class="fa fa-angle-double-up"></i>
</a></div>
<div class="widget-x-button" id="widget-expand-2" style="display: none;">
<a class="muted" data-remote="true" rel="nofollow" data-method="put" href="/widgets/2/toggle_display?collapsed=false"><i class="fa fa-angle-double-down"></i>
</a></div>
<div class="widget-x-button" id="widget-x-2">
<a class="muted" data-remote="true" rel="nofollow" data-method="put" href="/widgets/2/toggle_display?display=false"><i class="fa fa-times"></i>
</a></div>

</div>
</div>
<div id="widget-details-2">
<hr>
<div class="main-content awards">`;
    //console.log(topHTML);
    contract.methods.walletOfOwner(users[alias]).call().then(function(tokenIds) {
        console.log(tokenIds);


        let promises = [];

        tokenIds.forEach(token => {
            promises.push(Promise.resolve(contract.methods.tokenURI(token).call()));
        });

        Promise.all(promises).then(function(svgs) {

            svgs.forEach(svg => {
                topHTML += `<div class="award award-preview with-popover" data-content="Icon granted to those that have attended Introduction to Customer Obsession (CO1) training and..." data-original-title="Introduction to Customer Obsession (CO1)">
<div class="award-preview-img no-border">` + svg + `</div></div>`;
            });

            topHTML += `</div>
        <hr>
<div class="title">
<a href="/users/ronkenia/awards">View all of ` + alias + `'s NFTs</a>
</div>
</div>
</div>
<script>
  setup_widget_toggle(2);
  setup_widget_initial_display(2, false);
</script>

</div>`;

            $("#widgets2").prepend($(topHTML));
        });
    });
})();