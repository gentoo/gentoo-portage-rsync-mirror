# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Event-RPC/Event-RPC-1.10.0.ebuild,v 1.1 2011/08/31 10:40:12 tove Exp $

EAPI=4

MODULE_AUTHOR=JRED
MODULE_VERSION=1.01
inherit perl-module

DESCRIPTION="Event based transparent Client/Server RPC framework"

SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="|| ( dev-perl/Event dev-perl/glib-perl )
	dev-perl/IO-Socket-SSL
	dev-perl/Net-SSLeay
	virtual/perl-Storable"
DEPEND="${RDEPEND}"

SRC_TEST="do"
