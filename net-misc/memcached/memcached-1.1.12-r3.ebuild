# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/memcached/memcached-1.1.12-r3.ebuild,v 1.8 2014/01/08 06:19:21 vapier Exp $

inherit eutils user

DESCRIPTION="High-performance, distributed memory object caching system"

HOMEPAGE="http://www.danga.com/memcached/"

SRC_URI="http://www.danga.com/memcached/dist/${P}.tar.gz"

LICENSE="BSD"

SLOT="0"
KEYWORDS="amd64 arm ~hppa ia64 ~mips ppc ppc64 sh sparc x86"
IUSE="static perl doc"

DEPEND=">=dev-libs/libevent-0.6
		perl? ( dev-perl/Cache-Memcached )"

src_compile() {
	local myconf=""
	use static || myconf="--disable-static ${myconf}"
	econf ${myconf} || die "econf failed"
	emake || die
}

src_install() {
	dobin "${S}"/memcached
	dodoc "${S}"/{AUTHORS,COPYING,ChangeLog,INSTALL,NEWS,README}

	newconfd "${FILESDIR}/${PV}/conf" memcached

	newinitd "${FILESDIR}/${PV}/init" memcached

	doman "${S}"/doc/memcached.1

	if use doc; then
	  dodoc "${S}"/doc/{memory_management.txt,protocol.txt}
	fi
}

pkg_postinst() {
	enewuser memcached -1 -1 /dev/null daemon
}
