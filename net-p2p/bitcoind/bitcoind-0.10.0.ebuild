# Copyright 2010-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/bitcoind/bitcoind-0.10.0.ebuild,v 1.3 2015/02/25 05:35:07 patrick Exp $

EAPI=5

BITCOINCORE_COMMITHASH="047a89831760ff124740fe9f58411d57ee087078"
BITCOINCORE_LJR_DATE="20150220"
BITCOINCORE_IUSE="examples +ljr logrotate test upnp +wallet xt zeromq"
BITCOINCORE_POLICY_PATCHES="+cpfp +dcmp rbf spamfilter"
inherit bash-completion-r1 bitcoincore user systemd

DESCRIPTION="Original Bitcoin crypto-currency wallet for automated services"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"

RDEPEND="
	dev-libs/libsecp256k1
	virtual/bitcoin-leveldb
	logrotate? (
		app-admin/logrotate
	)
"
DEPEND="${RDEPEND}"

pkg_setup() {
	local UG='bitcoin'
	enewgroup "${UG}"
	enewuser "${UG}" -1 -1 /var/lib/bitcoin "${UG}"
}

src_configure() {
	# NOTE: --enable-zmq actually disables it
	bitcoincore_conf \
		--with-daemon
}

src_install() {
	bitcoincore_src_install

	insinto /etc/bitcoin
	newins "${FILESDIR}/bitcoin.conf" bitcoin.conf
	fowners bitcoin:bitcoin /etc/bitcoin/bitcoin.conf
	fperms 600 /etc/bitcoin/bitcoin.conf

	newconfd "${FILESDIR}/bitcoin.confd" ${PN}
	newinitd "${FILESDIR}/bitcoin.initd-r1" ${PN}
	systemd_dounit "${FILESDIR}/bitcoind.service"

	keepdir /var/lib/bitcoin/.bitcoin
	fperms 700 /var/lib/bitcoin
	fowners bitcoin:bitcoin /var/lib/bitcoin/
	fowners bitcoin:bitcoin /var/lib/bitcoin/.bitcoin
	dosym /etc/bitcoin/bitcoin.conf /var/lib/bitcoin/.bitcoin/bitcoin.conf

	dodoc doc/assets-attribution.md doc/tor.md
	doman contrib/debian/manpages/{bitcoind.1,bitcoin.conf.5}

	newbashcomp contrib/${PN}.bash-completion ${PN}

	if use examples; then
		docinto examples
		dodoc -r contrib/{bitrpc,pyminer,qos,spendfrom,tidy_datadir.sh}
	fi

	if use logrotate; then
		insinto /etc/logrotate.d
		newins "${FILESDIR}/bitcoind.logrotate" bitcoind
	fi
}
