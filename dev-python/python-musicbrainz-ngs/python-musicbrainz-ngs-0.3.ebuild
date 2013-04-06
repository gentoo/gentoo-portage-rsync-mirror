# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-musicbrainz-ngs/python-musicbrainz-ngs-0.3.ebuild,v 1.1 2013/04/06 22:35:02 sochotnicky Exp $

EAPI=4

PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5"
DISTUTILS_SRC_TEST=setup.py

inherit distutils vcs-snapshot

DESCRIPTION="This library implements webservice bindings for the Musicbrainz NGS site"
HOMEPAGE="https://github.com/alastair/python-musicbrainz-ngs"
SRC_URI="https://github.com/alastair/${PN}/tarball/v${PV} -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
