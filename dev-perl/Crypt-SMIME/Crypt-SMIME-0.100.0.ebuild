# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-SMIME/Crypt-SMIME-0.100.0.ebuild,v 1.1 2011/08/31 13:56:07 tove Exp $

EAPI=4

MODULE_AUTHOR=MIKAGE
MODULE_VERSION=0.10
inherit perl-module

DESCRIPTION="S/MIME sign, verify, encrypt and decrypt"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/openssl"
DEPEND="${RDEPEND}"
#	test? (
#		dev-perl/Test-Exception
#	)"

#SRC_TEST=do
