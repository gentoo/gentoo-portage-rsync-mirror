# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/safe_yaml/safe_yaml-1.0.3.ebuild,v 1.2 2014/06/14 03:04:47 mrueg Exp $

EAPI=5

USE_RUBY="ruby19 ruby20 ruby21 jruby"

RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_EXTRADOC="README.md"
RUBY_FAKEGEM_RECIPE_TEST="none"

inherit ruby-fakegem

DESCRIPTION="Parse YAML safely, without that pesky arbitrary object deserialization vulnerability"
HOMEPAGE="https://dtao.github.com/safe_yaml"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

ruby_add_bdepend "test? ( dev-ruby/hashie
	dev-ruby/heredoc_unindent
	dev-ruby/rspec:2 )"

each_ruby_test() {
	# Run specs with monkeypatch
	${RUBY} -S rspec --tag ~libraries || die

	# Running specs without monkeypatch
	${RUBY} -S rspec --tag libraries || die
}
