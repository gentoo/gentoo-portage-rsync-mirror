# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/elib-intl/elib-intl-0_pre20110711.ebuild,v 1.2 2014/05/25 22:15:49 nimiux Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Enhanced internationalization (I18N) services for your Python modules and applications"
HOMEPAGE="https://github.com/dieterv/elib.intl/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

KEYWORDS="amd64 ~x86"
LICENSE="GPL-3 LGPL-3"
SLOT="0"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"
