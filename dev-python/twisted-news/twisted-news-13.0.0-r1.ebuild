# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-news/twisted-news-13.0.0-r1.ebuild,v 1.9 2014/09/15 08:19:42 ago Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7} )

inherit twisted-r1

DESCRIPTION="Twisted News is an NNTP server and programming library"

KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="=dev-python/twisted-core-${TWISTED_RELEASE}*[${PYTHON_USEDEP}]
	=dev-python/twisted-mail-${TWISTED_RELEASE}*[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
