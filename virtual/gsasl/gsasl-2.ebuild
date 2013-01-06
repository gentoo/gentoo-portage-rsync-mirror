# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/gsasl/gsasl-2.ebuild,v 1.4 2012/10/20 17:47:35 jer Exp $

EAPI="2"

DESCRIPTION="Virtual for the GNU SASL library"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 arm ~hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~x86-macos"
IUSE=""

DEPEND="|| ( net-libs/libgsasl net-misc/gsasl )"
RDEPEND="${DEPEND}"
