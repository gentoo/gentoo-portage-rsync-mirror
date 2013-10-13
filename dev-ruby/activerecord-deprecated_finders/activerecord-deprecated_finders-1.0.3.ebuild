# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/activerecord-deprecated_finders/activerecord-deprecated_finders-1.0.3.ebuild,v 1.2 2013/10/13 22:08:37 maekke Exp $

EAPI=4
USE_RUBY="ruby19"

# this is not null so that the dependencies will actually be filled
RUBY_FAKEGEM_TASK_TEST="test"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.md"

inherit ruby-fakegem versionator

DESCRIPTION="This gem will be used to extract and deprecate old-style finder option hashes in Active Record"
HOMEPAGE="https://github.com/rails"
SLOT="$(get_version_component_range 1-2)"

LICENSE="MIT"

KEYWORDS="~amd64 ~arm"
IUSE="mysql postgres sqlite3"

# This should also include dev-ruby/activerecord:4.0, but that has a
# dependency on this gem so we would get a circular dependency. Could
# probably be worked around with ruby_add_pdepend, which we don't have
# yet.
ruby_add_bdepend "
	>=dev-ruby/minitest-3
	>=dev-ruby/sqlite3-1.3"
