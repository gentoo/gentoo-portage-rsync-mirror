# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MogileFS-Client/MogileFS-Client-1.13.ebuild,v 1.1 2010/10/29 02:02:37 robbat2 Exp $

MODULE_AUTHOR="DORMANDO"
inherit perl-module

DESCRIPTION="Client library for the MogileFS distributed file system"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND=">=dev-perl/IO-stringy-2.110
		dev-perl/libwww-perl
		dev-lang/perl"

# Tests only available if you have a local mogilefsd on 127.0.0.1:7001
#SRC_TEST="do"
mydoc="CHANGES TODO"
