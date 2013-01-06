# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/doctest-mode/doctest-mode-0.4.ebuild,v 1.9 2012/09/26 05:33:15 ulm Exp $

EAPI=2

inherit elisp

DESCRIPTION="An Emacs major mode for editing Python source"
HOMEPAGE="http://www.cis.upenn.edu/~edloper/projects/doctestmode/"
SRC_URI="http://python-mode.svn.sourceforge.net/viewvc/*checkout*/python-mode/trunk/python-mode/doctest-mode.el?revision=460 -> ${PN}.el"

LICENSE="HPND"
SLOT="0"
KEYWORDS="amd64 arm hppa ia64 ppc ppc64 s390 sh x86 ~x86-fbsd"
IUSE=""

DEPEND="!<app-emacs/python-mode-5.1.0"
RDEPEND="${DEPEND}"

S=${WORKDIR}
SITEFILE=60${PN}-gentoo.el

src_unpack() {
	cp "${DISTDIR}"/${PN}.el "${WORKDIR}"
}
