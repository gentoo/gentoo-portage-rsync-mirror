# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/net-server/net-server-0.990.0.ebuild,v 1.1 2011/08/27 18:25:01 tove Exp $

EAPI=4

MY_PN=Net-Server
MODULE_AUTHOR=RHANDOM
MODULE_VERSION=0.99
inherit perl-module

DESCRIPTION="Extensible, general Perl server engine"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="dev-perl/IO-Multiplex"
DEPEND="${RDEPEND}"

SRC_TEST="do"
