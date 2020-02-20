;; profiles.clj --- This is where you apply your OCD.
;;
;; Copyright (C) 2009-2020 Damon Kwok
;;
;; Author: damon-kwok <damon-kwok@outlook.com>
;; Date: 2020-02-20
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http:;;www.gnu.org/licenses/>.
;;
;; Code:
{
    :user {
        :mirrors {
            "central" {
                :name "aliyun"
                :url "https://maven.aliyun.com/nexus/content/groups/public"
            }
            "clojars" {
                :name "cnnic"
                :url "https://mirrors.cnnic.cn/clojars/"
            }
        }
    }
}
;;
;; profiles ends here
