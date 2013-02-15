# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libecap/libecap-0.2.0.ebuild,v 1.6 2013/02/15 19:06:49 ago Exp $

EAPI="4"

inherit autotools-utils eutils

DESCRIPTION="API for implementing ICAP content analysis and adaptation"
HOMEPAGE="http://www.e-cap.org/"
SRC_URI="http://www.measurement-factory.com/tmp/ecap/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="2"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc x86"
IUSE="static-libs"

RDEPEND="!net-libs/libecap:0"

DOCS=( CREDITS NOTICE README change.log )
