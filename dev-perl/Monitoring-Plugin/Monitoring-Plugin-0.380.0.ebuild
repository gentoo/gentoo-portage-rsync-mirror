# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Monitoring-Plugin/Monitoring-Plugin-0.380.0.ebuild,v 1.1 2015/01/31 23:03:02 mjo Exp $

EAPI=5

MODULE_AUTHOR="NIERLEIN"
MODULE_VERSION="0.38"

inherit perl-module

DESCRIPTION="Modules to streamline Nagios, Icinga, Shinken, etc. plugins"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-perl/Class-Accessor
	dev-perl/Config-Tiny
	dev-perl/Math-Calc-Units
	dev-perl/Params-Validate"

SRC_TEST=do
