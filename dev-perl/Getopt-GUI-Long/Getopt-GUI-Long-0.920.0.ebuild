# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Getopt-GUI-Long/Getopt-GUI-Long-0.920.0.ebuild,v 1.1 2012/06/24 19:36:40 tove Exp $

EAPI="4"

MODULE_AUTHOR="HARDAKER"
MODULE_VERSION=0.92
inherit perl-module

DESCRIPTION="Auto-GUI extending Getopt::Long"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/perl-File-Temp
	virtual/perl-Getopt-Long"
