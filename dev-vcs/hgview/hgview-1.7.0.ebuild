# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/hgview/hgview-1.7.0.ebuild,v 1.1 2012/12/05 09:53:20 kensington Exp $

EAPI=5

PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.* *-jython *-pypy-*"

inherit distutils

DESCRIPTION="PyQt4-based Mercurial log navigator"
HOMEPAGE="http://www.logilab.org/project/hgview"
SRC_URI="http://ftp.logilab.org/pub/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="dev-python/docutils
	dev-python/PyQt4[X]
	dev-python/qscintilla-python
	dev-vcs/mercurial"
DEPEND="${RDEPEND}
	doc? (
		app-text/asciidoc
		app-text/xmlto
	)"

# If this flag is not set, arguments are passed to the "build" command
# only for distutils_src_compile(), but not for distutils_src_install()
DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES="1"
PYTHON_MODNAME="hgext/hgview.py hgviewlib"

src_prepare() {
	# https://www.logilab.org/ticket/103668
	sed -i \
		-e 's:MANDIR=$(PREFIX)/man:MANDIR=$(PREFIX)/share/man:' \
		-e 's:$(INSTALL) $$i:$(INSTALL) -m 644 $$i:' \
		doc/Makefile || die

	distutils_src_prepare
}

src_compile() {
	distutils_src_compile $(use doc || echo --no-doc)
}

src_install() {
	distutils_src_install $(use doc || echo --no-doc)

	# Install Mercurial extension config file
	insinto /etc/mercurial/hgrc.d
	doins hgext/hgview.rc
}
