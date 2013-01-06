# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/LWP-UserAgent-Determined/LWP-UserAgent-Determined-1.60.0.ebuild,v 1.1 2012/05/23 18:28:21 tove Exp $

EAPI=4

MODULE_AUTHOR=JESSE
MODULE_VERSION=1.06
inherit perl-module

DESCRIPTION="A virtual browser that retries errors"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux ~x86-solaris"
IUSE=""

RDEPEND="dev-perl/libwww-perl"

SRC_TEST=no
