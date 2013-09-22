# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/cachefilesd/cachefilesd-0.10.5-r2.ebuild,v 1.3 2013/09/22 06:45:25 ago Exp $

EAPI=5

inherit eutils flag-o-matic systemd toolchain-funcs

DESCRIPTION="Provides a caching directory on an already mounted filesystem"
HOMEPAGE="http://people.redhat.com/~dhowells/fscache/"
SRC_URI="http://people.redhat.com/~dhowells/fscache/${P}.tar.bz2 -> ${P}.tar"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 x86"
IUSE="doc selinux"

src_prepare() {
	epatch "${FILESDIR}"/0.10.4-makefile.patch
	tc-export CC
	if ! use selinux; then
		sed -e '/^secctx/s:^:#:g' -i cachefilesd.conf || die
	fi

	append-flags -fpie
}

src_install() {
	default

	if use selinux; then
		insinto /usr/share/doc/${P}
		doins -r selinux
	fi

	dodoc howto.txt

	newconfd "${FILESDIR}"/cachefilesd.conf ${PN}
	newinitd "${FILESDIR}"/cachefilesd.init ${PN}

	systemd_dounit ${PN}.service

	keepdir /var/cache/fscache
}

pkg_postinst() {
	[[ -d /var/cache/fscache ]] && return
	elog "Before CacheFiles can be used, a directory for local storage"
	elog "must be created.  The default configuration of /etc/cachefilesd.conf"
	elog "uses /var/cache/fscache.  The filesystem mounted there must support"
	elog "extended attributes (mount -o user_xattr)."
	echo ""
	elog "Once that is taken care of, start the daemon, add -o ...,fsc"
	elog "to the mount options of your network mounts, and let it fly!"
}
