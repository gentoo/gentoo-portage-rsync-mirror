# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/localepurge/localepurge-0.5.3.3-r1.ebuild,v 1.1 2012/08/05 23:45:10 ottxor Exp $

EAPI=4

inherit eutils prefix

DESCRIPTION="Script to recover diskspace wasted for unneeded locale files and localized man pages."
HOMEPAGE="http://gentoo.org"
SRC_URI="mirror://gentoo/${P}.tbz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

DEPEND=""
RDEPEND="app-shells/bash"

S=${WORKDIR}/${PN}

src_prepare() {
	epatch "${FILESDIR}"/${P}-prefix.patch
	eprefixify localepurge
	sed -i -e 's/0.5.3.2/0.5.3.3/' localepurge || die
}

src_install() {
	insinto /var/cache/localepurge
	doins defaultlist
	dosym defaultlist /var/cache/localepurge/localelist
	insinto /etc
	doins locale.nopurge
	dobin localepurge
	doman localepurge.8
}
