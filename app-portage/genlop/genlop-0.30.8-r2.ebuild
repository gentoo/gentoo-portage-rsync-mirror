# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/genlop/genlop-0.30.8-r2.ebuild,v 1.9 2012/07/25 05:08:08 ryao Exp $

inherit eutils bash-completion

DESCRIPTION="A nice emerge.log parser"
HOMEPAGE="http://www.gentoo.org/proj/en/perl"
SRC_URI="mirror://gentoo//${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

DEPEND=">=dev-lang/perl-5.8.0-r12
	 >=dev-perl/DateManip-5.40
	 dev-perl/libwww-perl"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-version.patch"
	epatch "${FILESDIR}/${P}-compiling-category.patch"
}

src_install() {
	dobin genlop || die "failed to install genlop (via dobin)"
	dodoc README Changelog
	doman genlop.1
	dobashcompletion genlop.bash-completion genlop
}
