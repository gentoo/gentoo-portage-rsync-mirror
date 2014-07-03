# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/gettext_i18n_rails/gettext_i18n_rails-1.0.5.ebuild,v 1.1 2014/07/03 09:35:57 graaff Exp $

EAPI=5

# jruby support requires sqlite3 support for jruby.
USE_RUBY="ruby19 ruby20"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="Readme.md"

RUBY_FAKEGEM_RECIPE_TEST="rspec"

RUBY_FAKEGEM_EXTRAINSTALL="init.rb"

inherit ruby-fakegem

DESCRIPTION="FastGettext / Rails integration."
HOMEPAGE="https://github.com/grosser/gettext_i18n_rails"
SRC_URI="https://github.com/grosser/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_bdepend "test? ( dev-ruby/activerecord:3.2[sqlite3] dev-ruby/temple )"
ruby_add_rdepend ">=dev-ruby/fast_gettext-0.4.8"

all_ruby_prepare() {
	rm Gemfile Gemfile.lock || die

	# Remove specs for slim and hamlet, template engines we don't package.
	rm spec/gettext_i18n_rails/slim_parser_spec.rb spec/gettext_i18n_rails/haml_parser_spec.rb || die

	# Test against Rails 3.2 (newer versions don't work and we don't use
	# appraisals for now.
	sed -e '2igem "rails", "~>3.2.0"' -i spec/spec_helper.rb || die
}
