# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Stat-Moose/File-Stat-Moose-0.60.0-r1.ebuild,v 1.1 2014/08/26 18:51:49 axs Exp $

EAPI=5

MODULE_AUTHOR=DEXTER
MODULE_VERSION=0.06
inherit perl-module

DESCRIPTION="Status info for a file - Moose-based"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/DateTime
	virtual/perl-parent
	dev-perl/Sub-Exporter
	>=dev-perl/Exception-Warning-0.03
	>=dev-perl/Test-Unit-Lite-0.12
	>=dev-perl/Fatal-Exception-0.05
	>=dev-perl/Exception-Died-0.06
	dev-perl/constant-boolean
	>=dev-perl/Test-Assert-0.0501
	>=dev-perl/Exception-Base-0.22.01
	>=dev-perl/Exception-System-0.11
	dev-perl/Moose"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"
