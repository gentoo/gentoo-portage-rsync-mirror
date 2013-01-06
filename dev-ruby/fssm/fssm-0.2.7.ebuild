# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/fssm/fssm-0.2.7.ebuild,v 1.5 2012/05/01 18:24:04 armin76 Exp $

EAPI=4

USE_RUBY="ruby18 ruby19 ree18 jruby"

RUBY_FAKEGEM_TASK_TEST="spec"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.markdown"

inherit ruby-fakegem

DESCRIPTION="Monitor API"
HOMEPAGE="http://github.com/ttilley/fssm"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

ruby_add_bdepend "test? ( >=dev-ruby/rspec-2.4.0:2 )"

each_ruby_prepare() {
	# Remove bundler support
	sed -i -e '/[Bb]undler/d' Rakefile spec/spec_helper.rb || die
	rm Gemfile || die
}

all_ruby_install() {
	all_fakegem_install

	dodoc example.rb
}
