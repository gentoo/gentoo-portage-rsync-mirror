# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/flow-tools/flow-tools-0.68.5.1-r2.ebuild,v 1.5 2013/02/26 15:41:31 jer Exp $

EAPI=4
inherit user

DESCRIPTION="library and programs to collect, send, process, and generate reports from NetFlow data"
HOMEPAGE="http://code.google.com/p/flow-tools/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.bz2"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="debug mysql postgres ssl static-libs"

RDEPEND="sys-apps/tcp-wrappers
	sys-libs/zlib
	mysql? ( virtual/mysql )
	postgres? ( dev-db/postgresql-base )
	ssl? ( dev-libs/openssl )"

DEPEND="${RDEPEND}
	sys-devel/flex
	sys-devel/bison"

DOCS=( ChangeLog README SECURITY TODO )

pkg_setup() {
	enewgroup flows
	enewuser flows -1 -1 /var/lib/flows flows
}

src_prepare() {
	sed -i \
		-e 's|/var/run/|/run/|g' \
		src/flow-capture.c \
		src/flow-fanout.c \
		|| die
}

src_configure() {
	local myconf="--sysconfdir=/etc/flow-tools"
	use mysql && myconf="${myconf} --with-mysql"
	if use postgres; then
		myconf="${myconf} --with-postgresql=yes"
	else
		myconf="${myconf} --with-postgresql=no"
	fi
	use ssl && myconf="${myconf} --with-openssl"
	econf ${myconf} $(use_enable static-libs static)
}

src_install() {
	default

	exeinto /var/lib/flows/bin
	keepdir /run/flows
	keepdir /var/lib/flows
	keepdir /var/lib/flows/bin
	doexe "${FILESDIR}"/linkme

	newinitd "${FILESDIR}/flowcapture.initd" flowcapture
	newconfd "${FILESDIR}/flowcapture.confd" flowcapture

	if ! use static-libs; then
		rm -f "${D}"/usr/lib*/libft.la || die
	fi

	fowners flows:flows /run/flows
	fowners flows:flows /var/lib/flows
	fowners flows:flows /var/lib/flows/bin
	fperms 0755 /run/flows
	fperms 0755 /var/lib/flows
	fperms 0755 /var/lib/flows/bin
}
