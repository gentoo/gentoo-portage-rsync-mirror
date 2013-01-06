# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-Rijndael/Crypt-Rijndael-1.110.0.ebuild,v 1.6 2012/12/29 14:19:45 ago Exp $

EAPI=4

MODULE_AUTHOR=BDFOY
MODULE_VERSION=1.11
inherit perl-module

DESCRIPTION="Crypt::CBC compliant Rijndael encryption module"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 hppa ia64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE="test"

DEPEND="
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)"

SRC_TEST="do"
