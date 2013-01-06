# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/yaml-mode/yaml-mode-0.0.8.ebuild,v 1.3 2012/04/23 20:53:52 ulm Exp $

EAPI=4

inherit elisp

DESCRIPTION="A major mode for GNU Emacs for editing YAML files"
HOMEPAGE="https://github.com/yoshiki/yaml-mode"
SRC_URI="mirror://github/yoshiki/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DOCS="README Changes"
SITEFILE="50${PN}-gentoo.el"
