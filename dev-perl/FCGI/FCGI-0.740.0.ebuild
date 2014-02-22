# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/FCGI/FCGI-0.740.0.ebuild,v 1.8 2014/02/22 09:40:24 ulm Exp $

EAPI=4

MODULE_AUTHOR=FLORA
MODULE_VERSION=0.74
inherit perl-module

DESCRIPTION="Fast CGI"

LICENSE="FastCGI"
SLOT="0"
KEYWORDS="amd64 ~arm ~hppa ppc ~ppc64 x86"
IUSE=""

SRC_TEST="do"
