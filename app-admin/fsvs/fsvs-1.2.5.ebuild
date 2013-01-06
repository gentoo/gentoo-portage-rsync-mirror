# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/fsvs/fsvs-1.2.5.ebuild,v 1.1 2012/10/22 10:29:15 pinkbyte Exp $

EAPI=4

inherit eutils

DESCRIPTION="Backup/restore for subversion backends"
HOMEPAGE="http://fsvs.tigris.org/"
SRC_URI="http://download.fsvs-software.org/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-vcs/subversion-1.2
	>=dev-libs/libpcre-6.4
	>=sys-libs/gdbm-1.8
	>=dev-libs/apr-util-1.2
	dev-util/ctags"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/fsvs-1.2.4-as-needed.patch"
}

src_install() {
	dobin src/fsvs
	dodir /etc/fsvs
	dodir /var/spool/fsvs
	keepdir /var/spool/fsvs
	doman doc/*5 doc/*1
	dodoc doc/{FAQ,IGNORING,PERFORMANCE,USAGE}
}

pkg_postinst() {
	elog "Remember, this system works best when you're connecting to a remote"
	elog "svn server."
	elog
	elog "Go to the base path for versioning:"
	elog "    cd /"
	elog "Tell fsvs which URL it should use:"
	elog "    fsvs url svn+ssh://username@machine/path/to/repos"
	elog "Define ignore patterns - all virtual filesystems (/proc, /sys, etc.),"
	elog "and (assuming that you're in / currently) the temporary files in /tmp:"
	elog "    fsvs ignore DEVICE:0 ./tmp/*"
	elog "And you're ready to play!"
	elog "Check your data in:"
	elog "    fsvs commit -m \"First import\""
}
