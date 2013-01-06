# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MogileFS-Utils/MogileFS-Utils-2.250.0.ebuild,v 1.1 2012/06/29 17:09:40 robbat2 Exp $

EAPI=4

MODULE_AUTHOR=DORMANDO
MODULE_VERSION=${PV%0.0}
inherit perl-module

DESCRIPTION="Server for the MogileFS distributed file system"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="virtual/perl-IO-Compress
	dev-perl/libwww-perl
	>=dev-perl/MogileFS-Client-1.16"
DEPEND="${RDEPEND}"
