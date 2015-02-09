# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/t-coffee/t-coffee-8.93.ebuild,v 1.3 2015/02/09 12:50:38 blueness Exp $

EAPI="2"

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="A multiple sequence alignment package"
HOMEPAGE="http://www.tcoffee.org/Projects_home_page/t_coffee_home_page.html"
SRC_URI="http://www.tcoffee.org/Packages/T-COFFEE_distribution_Version_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE="examples test"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"

RDEPEND="sci-biology/clustalw"
DEPEND="${DEPEND}
	test? ( dev-lang/perl )"

S="${WORKDIR}/T-COFFEE_distribution_Version_${PV}"

die_compile() {
	echo
	eerror "If you experience an internal compiler error (consult the above"
	eerror "messages), try compiling t-coffee using very modest compiler flags."
	eerror "See bug #114745 on the Gentoo Bugzilla for more details."
	die "Compilation failed"
}

src_prepare() {
	epatch "${FILESDIR}"/8.69-flags.patch
	epatch "${FILESDIR}"/8.69-test.patch
}

src_compile() {
	[[ $(gcc-version) == "3.4" ]] && append-flags -fno-unit-at-a-time
	[[ $(gcc-version) == "4.1" ]] && append-flags -fno-unit-at-a-time
	emake \
		CC="$(tc-getCC)" CFLAGS="${CFLAGS}" \
		-C t_coffee_source || die_compile
}

src_test() {
	cd "${TCDIR}"
	perl bin/test.pl || die
}

src_install() {
	dobin t_coffee_source/t_coffee || die "Failed to install program."

#	insinto /usr/share/${PN}/lib/html
#	doins html/* || die "Failed to install Web interface files."

	dodoc doc/*.txt || die "Failed to install text documentation."
	dohtml doc/*.htm || die "Failed to install HTML documentation."

	insinto /usr/share/doc/${PF}
	doins doc/*.doc || die "Failed to install DOC documentation."

	if use examples; then
		insinto /usr/share/${PN}
		doins -r example || die "Failed to install example files."
	fi
}
