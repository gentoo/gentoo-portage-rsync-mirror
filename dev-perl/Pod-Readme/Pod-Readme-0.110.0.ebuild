# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Pod-Readme/Pod-Readme-0.110.0.ebuild,v 1.1 2011/08/29 10:35:18 tove Exp $

EAPI=4

MODULE_AUTHOR=BIGPRESH
MODULE_VERSION=0.11
inherit perl-module

DESCRIPTION="Convert POD to README file"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/regexp-common"
DEPEND="${RDEPEND}"

SRC_TEST="do"
