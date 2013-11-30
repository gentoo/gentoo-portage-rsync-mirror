# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rb-gsl/rb-gsl-1.15.3-r1.ebuild,v 1.1 2013/11/30 19:50:50 mrueg Exp $

EAPI=5
USE_RUBY="ruby19 ruby20"

RUBY_FAKEGEM_NAME="gsl"
inherit ruby-fakegem

DESCRIPTION="Ruby interface to GNU Scientific Library"
HOMEPAGE="http://rb-gsl.rubyforge.org/ https://github.com/david-macmahon/rb-gsl"
#SRC_URI="https://github.com/david-macmahon/${PN}/archive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

DEPEND+=" sci-libs/gsl"
RDEPEND+=" sci-libs/gsl"

RUBY_S="${PN}-${P}"

each_ruby_prepare() {
	sed -e \
		"/ruby -w -I/ s:#\truby -w *:${RUBY} -w -I ../../lib -I ../../ext -I . :" \
		-e "/ruby -w \`basename/ s/^/# /" -i tests/run-test.sh || die
	sed -i '/$CPPFLAGS =/a \$LDFLAGS = " -L#{narray_config} -l:narray.so "+$LDFLAGS' ext/extconf.rb || die
	sed -i -e 's/qactual/actual/' tests/linalg/TDN.rb || die
}

each_ruby_configure() {
	${RUBY} setup.rb config || die
}

each_ruby_compile() {
	${RUBY} setup.rb setup || die
}

each_ruby_install() {
	${RUBY} setup.rb install --prefix="${D}" || die
}

each_ruby_test() {
	cd tests || die
	./run-test.sh || die
}
