# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/rebar/rebar-2.0.0.ebuild,v 1.1 2012/10/05 11:10:34 djc Exp $

EAPI=4

inherit bash-completion-r1 vcs-snapshot

DESCRIPTION="A sophisticated build-tool for Erlang projects that follows OTP principles"
HOMEPAGE="http://github.com/basho/rebar"
SRC_URI="http://github.com/basho/${PN}/tarball/${PV} -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-lang/erlang"
DEPEND="${RDEPEND}"

src_test() {
	emake xref
}

src_install() {
	dobin rebar
	dodoc rebar.config.sample THANKS
	dobashcomp priv/shell-completion/bash/${PN}
}
