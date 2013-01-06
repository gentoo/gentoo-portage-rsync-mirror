# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/POE-Component-PreforkDispatch/POE-Component-PreforkDispatch-0.101.0.ebuild,v 1.1 2011/08/29 11:02:42 tove Exp $

EAPI=4

MODULE_AUTHOR=EWATERS
MODULE_VERSION=0.101
inherit perl-module

DESCRIPTION="Preforking task dispatcher"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/Error
	dev-perl/IO-Capture
	dev-perl/Params-Validate
	dev-perl/POE"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"
