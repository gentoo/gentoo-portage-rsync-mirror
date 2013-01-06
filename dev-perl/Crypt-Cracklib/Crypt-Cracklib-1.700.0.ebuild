# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-Cracklib/Crypt-Cracklib-1.700.0.ebuild,v 1.4 2012/05/28 15:58:45 armin76 Exp $

EAPI=4

MODULE_AUTHOR=DANIEL
MODULE_VERSION=1.7
inherit perl-module

DESCRIPTION="Perl interface to Alec Muffett's Cracklib"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="amd64 x86"
IUSE="test"

RDEPEND="sys-libs/cracklib"
DEPEND="${RDEPEND}
	test? ( dev-perl/Pod-Coverage
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST="do"
