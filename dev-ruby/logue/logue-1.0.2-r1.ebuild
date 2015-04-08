# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/logue/logue-1.0.2-r1.ebuild,v 1.2 2015/02/10 09:23:14 ago Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="Features.txt History.txt README.md"

inherit ruby-fakegem

DESCRIPTION="A module that adds logging/trace functionality"
HOMEPAGE="https://github.com/jpace/logue"

SRC_URI="https://github.com/jpace/logue/archive/v${PV}.tar.gz -> ${PN}-git-${PV}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE=""

ruby_add_rdepend ">=dev-ruby/rainbow-2.0.0"

all_ruby_prepare() {
	sed -i -e "s/run_test/do_run_test/" test/logue/testlog/log_stack_test.rb || die
}
