# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/shoulda-matchers/shoulda-matchers-2.6.0.ebuild,v 1.1 2014/04/19 03:21:35 mrueg Exp $

EAPI=5

USE_RUBY="ruby19"

RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_RECIPE_TEST=""

RUBY_FAKEGEM_EXTRAINSTALL="NEWS.md README.md"

inherit ruby-fakegem

DESCRIPTION="Making tests easy on the fingers and eyes"
HOMEPAGE="https://github.com/thoughtbot/shoulda-matchers"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

ruby_add_rdepend ">=dev-ruby/activesupport-3.0.0"
