# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/webassets/webassets-0.10.1.ebuild,v 1.1 2014/09/30 04:48:19 yngwin Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_3} )
inherit distutils-r1

DESCRIPTION="Asset management for Python web development"
HOMEPAGE="https://github.com/miracle2k/webassets"
SRC_URI="https://github.com/miracle2k/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"
