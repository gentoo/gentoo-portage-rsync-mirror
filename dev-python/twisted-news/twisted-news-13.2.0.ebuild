# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-news/twisted-news-13.2.0.ebuild,v 1.6 2015/03/09 00:01:02 pacho Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7} )

inherit twisted-r1

DESCRIPTION="Twisted News is an NNTP server and programming library"

KEYWORDS="~alpha amd64 ~ia64 ppc ppc64 ~sparc x86"
IUSE=""

DEPEND="=dev-python/twisted-core-${TWISTED_RELEASE}*[${PYTHON_USEDEP}]
	=dev-python/twisted-mail-${TWISTED_RELEASE}*[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
