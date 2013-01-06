# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-Rijndael/Crypt-Rijndael-1.90.0.ebuild,v 1.2 2011/09/03 21:05:02 tove Exp $

EAPI=4

MODULE_AUTHOR=BDFOY
MODULE_VERSION=1.09
inherit perl-module

DESCRIPTION="Crypt::CBC compliant Rijndael encryption module"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ia64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE="test"

RDEPEND=""
DEPEND="
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)"

SRC_TEST="do"
