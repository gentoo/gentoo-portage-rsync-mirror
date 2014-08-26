# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/B-OPCheck/B-OPCheck-0.290.0-r1.ebuild,v 1.1 2014/08/26 17:16:31 axs Exp $

EAPI=5

MODULE_AUTHOR=FLORA
MODULE_VERSION=0.29
inherit perl-module

DESCRIPTION="PL_check hacks using Perl callbacks"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-perl/B-Utils-0.08
	dev-perl/Scope-Guard"
DEPEND="${RDEPEND}
	>=dev-perl/extutils-depends-0.302"

PATCHES=( "${FILESDIR}"/0.29-Perl_check_t.patch )
SRC_TEST=do
