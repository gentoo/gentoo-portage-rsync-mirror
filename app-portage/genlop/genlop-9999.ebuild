# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/genlop/genlop-9999.ebuild,v 1.1 2013/01/07 19:28:30 fuzzyray Exp $

EAPI="5"

inherit git-2 bash-completion-r1

EGIT_REPO_URI="git://github.com/gentoo-perl/genlop.git"
DESCRIPTION="A nice emerge.log parser"
HOMEPAGE="http://www.gentoo.org/proj/en/perl"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-lang/perl
	 dev-perl/DateManip
	 dev-perl/libwww-perl"
RDEPEND="${DEPEND}"

src_install() {
	dobin genlop || die "failed to install genlop (via dobin)"
	dodoc README Changelog
	doman genlop.1
	newbashcomp genlop.bash-completion genlop
}
