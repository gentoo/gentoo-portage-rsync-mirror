# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/localepurge/localepurge-0.5.4-r1.ebuild,v 1.12 2014/08/10 01:37:39 patrick Exp $

EAPI=4

inherit eutils prefix

DESCRIPTION="Script to recover diskspace wasted for unneeded locale files and localized man pages"
HOMEPAGE="http://gentoo.org
http://git.overlays.gentoo.org/gitweb/?p=proj/localepurge.git;a=summary"
SRC_URI="http://dev.gentoo.org/~hwoarang/distfiles/${P}.tbz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

DEPEND=""
RDEPEND="app-shells/bash"

S=${WORKDIR}/${PN}

src_prepare() {
	epatch "${FILESDIR}"/${P}-prefix.patch
	# 164544
	epatch "${FILESDIR}"/${P}-directorysum.patch
	# 445910
	epatch "${FILESDIR}"/${P}-parentdir.patch
	eprefixify ${PN}
}

src_install() {
	insinto /var/cache/${PN}
	doins defaultlist
	dosym defaultlist /var/cache/${PN}/localelist
	insinto /etc
	doins locale.nopurge
	dobin ${PN}
	doman ${PN}.8
}
