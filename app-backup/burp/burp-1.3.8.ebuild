# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/burp/burp-1.3.8.ebuild,v 1.1 2014/12/01 16:28:47 aidecoe Exp $

EAPI=5

inherit eutils user

DESCRIPTION="Network backup and restore client and server for Unix and Windows"
HOMEPAGE="http://burp.grke.org/"
SRC_URI="http://burp.grke.org/downloads/${P}/${P}.tar.bz2"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="acl afs nls ssl tcpd xattr"

DEPEND="
	dev-libs/uthash
	sys-libs/libcap
	net-libs/librsync
	sys-libs/ncurses
	sys-libs/zlib
	acl? ( sys-apps/acl )
	afs? ( net-fs/openafs )
	nls? ( sys-devel/gettext )
	ssl? ( dev-libs/openssl )
	tcpd? ( sys-apps/tcp-wrappers )
	xattr? ( sys-apps/attr )
	"
RDEPEND="${DEPEND}
	virtual/logger
	"

DOCS=( CONTRIBUTORS DONATIONS UPGRADING )
PATCHES=( "${FILESDIR}/${PV}-bedup-conf-path.patch" )
S="${WORKDIR}/burp"

pkg_setup() {
	enewgroup "${PN}"
	enewuser "${PN}" -1 "" "" "${PN}"
}

src_prepare() {
	epatch "${PATCHES[@]}"
}

src_configure() {
	local myeconfargs=(
		--sbindir=/usr/sbin
		--sysconfdir=/etc/burp
		--enable-largefile
		$(use_with ssl openssl)
		$(use_enable acl)
		$(use_enable afs)
		$(use_enable nls)
		$(use_enable xattr)
		$(use_with tcpd tcp-wrappers)
	)
	econf "${myeconfargs[@]}"
}

src_install() {
	default

	fowners root:burp /etc/burp /var/spool/burp
	fperms 0775 /etc/burp /var/spool/burp
	fowners root:burp /etc/burp/clientconfdir
	fperms 0750 /etc/burp/clientconfdir
	fowners root:burp /etc/burp/burp-server.conf
	fperms 0640 /etc/burp/burp-server.conf

	if use ssl; then
		# The server will create this directory if it doesn't exist, but the
		# client won't.  It must be writable by both.
		dodir /etc/burp/CA
		fowners root:burp /etc/burp/CA
		fperms 0775 /etc/burp/CA
	fi

	newinitd "${FILESDIR}"/${PN}.initd ${PN}
	dodoc docs/*

	sed -e 's|^# user=graham|user = burp|' \
		-e 's|^# group=nogroup|group = burp|' \
		-e 's|^pidfile = .*|lockfile = /run/lock/burp/server.lock|' \
		-i "${D}"/etc/burp/burp-server.conf || die
}

pkg_postinst() {
	if use ssl && [ ! -e /etc/burp/CA/index.txt ]; then
		elog "At first run burp server will generate DH parameters and SSL"
		elog "certificates.  You should adjust configuration before."
		elog "Server configuration is located at"
		elog ""
		elog "  /etc/burp/burp-server.conf"
		elog ""
	fi
}
