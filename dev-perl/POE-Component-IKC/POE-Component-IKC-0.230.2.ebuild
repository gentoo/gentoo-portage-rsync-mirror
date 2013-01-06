# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/POE-Component-IKC/POE-Component-IKC-0.230.2.ebuild,v 1.1 2011/09/11 01:32:08 robbat2 Exp $

EAPI=2

MODULE_AUTHOR="GWYN"
MODULE_VERSION=0.2302
inherit perl-module

DESCRIPTION="POE Inter-Kernel Communication"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-perl/POE-API-Peek-1.34
	dev-perl/POE"
RDEPEND="${DEPEND}"
