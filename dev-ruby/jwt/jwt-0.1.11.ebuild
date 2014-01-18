# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/jwt/jwt-0.1.11.ebuild,v 1.1 2014/01/18 07:17:06 mrueg Exp $

EAPI=5
USE_RUBY="ruby18 ruby19 ruby20 jruby"

RUBY_FAKEGEM_RECIPE_TEST="rspec"

RUBY_FAKEGEM_TASK_DOC=""

inherit ruby-fakegem

DESCRIPTION="A Ruby implementation of JSON Web Token draft 06."
HOMEPAGE="https://github.com/progrium/ruby-jwt"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_bdepend "test? ( dev-ruby/echoe )"
ruby_add_rdepend ">=dev-ruby/multi_json-1.5.1"
