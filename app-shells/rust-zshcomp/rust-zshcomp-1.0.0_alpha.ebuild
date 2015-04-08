# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/rust-zshcomp/rust-zshcomp-1.0.0_alpha.ebuild,v 1.1 2015/02/10 12:02:09 jauhien Exp $

EAPI="5"

MY_PV="rustc-1.0.0-alpha"
DESCRIPTION="Rust zsh completions"
HOMEPAGE="http://www.rust-lang.org/"
SRC_URI="http://static.rust-lang.org/dist/${MY_PV}-src.tar.gz"

LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-shells/zsh"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PV}"

src_configure() {
	:
}

src_compile() {
	:
}

src_install() {
	insinto /usr/share/zsh/site-functions
	doins src/etc/zsh/_rust
}
