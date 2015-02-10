# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/rust-mode/rust-mode-1.0.0_alpha.ebuild,v 1.1 2015/02/10 11:57:51 jauhien Exp $

EAPI="5"

inherit elisp

MY_PV="rustc-1.0.0-alpha"

DESCRIPTION="A major emacs mode for editing Rust source code"
HOMEPAGE="http://www.rust-lang.org/"
SRC_URI="http://static.rust-lang.org/dist/${MY_PV}-src.tar.gz"

LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/${MY_PV}/src/etc/emacs"

SITEFILE="50${PN}-gentoo.el"
