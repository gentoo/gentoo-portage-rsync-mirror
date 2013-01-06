# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Date-Simple/Date-Simple-3.30.0.ebuild,v 1.1 2011/08/31 12:43:19 tove Exp $

EAPI=4

MODULE_AUTHOR=IZUT
MODULE_VERSION=3.03
inherit perl-module

DESCRIPTION="A simple date object"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 GPL-3 )" # Artistic or GPL2+
KEYWORDS="~amd64 ~x86 ~x86-solaris"
IUSE=""

SRC_TEST=do
